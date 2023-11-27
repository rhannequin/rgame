# frozen_string_literal: true

require "rails_helper"

describe Planets::MetalMineUpgradeForm do
  describe "#valid?" do
    context "when all conditions are met" do
      it "returns true" do
        stub_metal_mine_upgrade
        planet = build_stubbed(:planet, metal: 100)
        form = described_class.new(planet: planet)

        expect(form.valid?).to be true
      end
    end

    context "when there is a pending upgrade" do
      it "returns false" do
        stub_metal_mine_upgrade
        planet = create(:planet, metal: 100)
        create(:metal_mine_upgrade, :in_progress, planet: planet)
        form = described_class.new(planet: planet)

        expect(form.valid?).to be false
        expect(form.errors).to be_added(:base, :pending_upgrade)
      end
    end

    context "when there are insufficient resources" do
      it "returns false" do
        stub_metal_mine_upgrade(cost: 150)
        planet = build_stubbed(:planet, metal: 100)
        form = described_class.new(planet: planet)

        expect(form.valid?).to be false
        expect(form.errors).to be_added(:base, :insufficient_resources)
      end
    end
  end

  describe "#save" do
    it "creates a metal mine upgrade" do
      stub_metal_mine_upgrade
      planet = create(:planet, metal: 100)
      form = described_class.new(planet: planet)

      expect { form.save }.to change(planet.pending_metal_mine_upgrades, :count).by(1)
    end

    it "deducts the cost from the planet" do
      stub_metal_mine_upgrade
      planet = create(:planet, metal: 100)
      form = described_class.new(planet: planet)

      expect { form.save }.to change { planet.reload.metal }.by(-50)
    end

    it "schedules a job for completion" do
      freeze_time do
        stub_metal_mine_upgrade(duration: 2.minutes)
        allow(CompleteMetalMineUpgradeJob).to receive(:perform_at)
        planet = create(:planet, metal: 100)
        form = described_class.new(planet: planet)

        form.save

        expect(CompleteMetalMineUpgradeJob).to(
          have_received(:perform_at).with(
            2.minutes.from_now,
            planet.pending_metal_mine_upgrades.first.id
          )
        )
      end
    end

    context "when the form is invalid" do
      it "returns false" do
        stub_metal_mine_upgrade(cost: 150)
        planet = build_stubbed(:planet, metal: 100)
        form = described_class.new(planet: planet)

        expect(form.save).to be false
      end
    end

    context "when it fails" do
      it "doesn't cost resources to the planet and doesn't start the upgrade" do
        stub_metal_mine_upgrade
        planet = create(:planet, metal: 100)
        form = described_class.new(planet: planet)
        allow(planet).to receive(:save!).and_raise(ActiveRecord::RecordInvalid)

        form.save
      rescue ActiveRecord::RecordInvalid
        expect(planet.reload.metal).to eq(100)
        expect(planet.pending_metal_mine_upgrades.count).to eq(0)
      end
    end
  end

  def stub_metal_mine_upgrade(cost: 50, duration: 2.minutes)
    allow(MetalMineUpgrade).to receive_messages(
      cost_for_level: cost,
      duration_for_level: duration
    )
  end
end
