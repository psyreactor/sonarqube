# frozen_string_literal: true

class Sonarqube::Client
  # Defines methods related to tokens.
  # @see https://SONAR_URL/web_api/api/qualitygates
  module QualityGates
    ALLOWED_OPERATORS = %w[LT GT].freeze
    ALLOWED_METRICS = %w[
      coverage new_coverage duplicated_lines_density
      new_duplicated_lines_density reliability_rating new_reliability_rating
      maintainability_rating new_maintainability_rating
    ].freeze
    # Create new quality gate.
    #
    # @example
    #   Sonarqube.create_quality_gate('name_quality_gate')
    #
    #   # Gracefully continue if gate already exists
    #   begin
    #     Sonarqube.create_quality_gate('name_quality_gate')
    #   rescue Sonarqube::Error::BadRequest => error
    #     raise unless error.message =~ /Name has already been taken/
    #   end
    #
    # @param  [String] name (required) Quality Gate name.
    # @return [Sonarqube::ObjectifiedHash]
    def create_quality_gate(name)
      raise ArgumentError, 'Missing required parameters' if name.nil?

      body = { name: name }
      post('/api/qualitygates/create', body: body)
    end
    alias quality_gate_create create_quality_gate

    # Create condition for a quality gate.
    #
    # @example
    #   # Create a condition that errors when coverage is below 90%
    #   Sonarqube.create_quality_gate_condition('name_quality_gate', 'coverage', '90')
    #
    #   # Create a condition that errors when code duplication is > 3%
    #   Sonarqube.create_quality_gate_condition('name_quality_gate', 'duplicated_lines_density',
    #                                           '3', 'GT')
    #
    # @param  [String] name (required) Quality Gate name.
    # @param  [String] metric (required) SonarQube metric name.
    # @param  [String] error_threshold (required) Error threshold value
    # @param  [String] operator (required) Operator - LT for <; GT for >
    # @return [Sonarqube::ObjectifiedHash]
    def create_quality_gate_condition(name, metric, error_threshold, operator = 'LT')
      raise ArgumentError, 'Missing required parameters' if name.nil? || metric.nil? || error_threshold.nil?
      unless ALLOWED_OPERATORS.include?(operator)
        raise ArgumentError, "Operator must be in #{ALLOWED_OPERATORS.join(', ')}"
      end
      raise ArgumentError, "Metric must be in #{ALLOWED_METRICS.join(', ')}" unless ALLOWED_METRICS.include?(metric)

      body = {
        gateName: name,
        metric: metric,
        error: error_threshold,
        op: operator
      }
      post('/api/qualitygates/create_condition', body: body)
    end
    alias quality_gate_condition_create create_quality_gate_condition

    # Set the default quality gate.
    #
    # @example
    #   Sonarqube.set_default_quality_gate('name_quality_gate')
    #
    # @param  [String] name (required) Quality Gate name.
    # @return [Sonarqube::ObjectifiedHash]
    # rubocop:disable Naming/AccessorMethodName
    def set_default_quality_gate(name)
      raise ArgumentError, 'Missing required parameters' if name.nil?

      body = { name: name }
      post('/api/qualitygates/set_as_default', body: body)
    end
    # rubocop:enable Naming/AccessorMethodName
    alias default_quality_gate_set set_default_quality_gate

    # List quality gates.
    #
    # @example
    #   Sonarqube.list_quality_gates
    #
    # @return [Sonarqube::ObjectifiedHash].
    def list_quality_gates
      get('/api/qualitygates/list')
    end
    alias quality_gates_list list_quality_gates
  end
end
