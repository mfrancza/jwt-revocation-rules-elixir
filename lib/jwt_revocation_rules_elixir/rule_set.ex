defmodule JwtRevocationRulesElixir.RuleSet do
  alias __MODULE__
  alias JwtRevocationRulesElixir.Rule
  alias JwtRevocationRulesElixir.Claims

  @spec __struct__ :: %RuleSet{rules: [%Rule{}], timestamp: integer()}
  @doc """
  The set of rules to apply to determine if a JWT has been revoked
  """
  @enforce_keys [:rules, :timestamp]
  defstruct [rules: [], timestamp: 0]

  @spec is_met_by(%RuleSet{}, %Claims{}) :: %Rule{} | nil
  @doc """
  Returns a rule in `ruleset` which `claims` meets, or nil if no Rules are met by it
  """
  def is_met_by(%RuleSet{} = ruleset, %Claims{} = claims) do
    Enum.find(ruleset.rules, fn rule -> Rule.is_met(rule, claims) end)
  end

  @spec is_met(%RuleSet{}, %Claims{}) :: boolean()
  @doc """
  Returns if at least one of the rules in `ruleset` is met by `claims`
  """
  def is_met(%RuleSet{} = ruleset, %Claims{} = claims) do
    is_met_by(ruleset, claims) != nil
  end
end
