# frozen_string_literal: true

require 'spec_helper'

describe Sonarqube::Client do
  describe '.quality_gate_create' do
    before do
      stub_post('/api/qualitygates/create', 'quality_gates_create')
      @quality_gate = Sonarqube.create_quality_gate('name_quality_gate')
    end

    it 'gets the correct resource' do
      expect(a_post('/api/qualitygates/create')).to have_been_made
    end

    it 'returns the quality gate ID' do
      expect(@quality_gate).to be_a Sonarqube::ObjectifiedHash
      expect(@quality_gate.id).to eq('AU-Tpxb--iU5OvuD2FLy')
    end
  end

  describe '.quality_gate_condition_create' do
    before do
      stub_post('/api/qualitygates/create_condition', 'quality_gates_condition_create')
      @condition = Sonarqube.create_quality_gate_condition('name_quality_gate',
                                                           'coverage', '90',
                                                           'LT')
    end

    it 'gets the correct resource' do
      expect(a_post('/api/qualitygates/create_condition')).to have_been_made
    end

    it 'returns the quality gate condition details' do
      expect(@condition).to be_a Sonarqube::ObjectifiedHash
      expect(@condition.metric).to eq('coverage')
    end
  end

  describe '.default_quality_gate_set' do
    before do
      stub_post('/api/qualitygates/set_as_default', 'quality_gates_set_default')
      Sonarqube.set_default_quality_gate('name_quality_gate')
    end

    it 'gets the correct resource' do
      expect(a_post('/api/qualitygates/set_as_default')).to have_been_made
    end
  end

  describe '.quality_gates_list' do
    before do
      stub_get('/api/qualitygates/list', 'quality_gates_list')
      @result = Sonarqube.list_quality_gates
    end

    it 'returns array of quality gates' do
      expect(@result.qualitygates).to be_a(Array)
    end

    it 'provides details of each quality gate' do
      expect(@result.qualitygates.first.name).to eq('Sonar way')
    end
  end
end
