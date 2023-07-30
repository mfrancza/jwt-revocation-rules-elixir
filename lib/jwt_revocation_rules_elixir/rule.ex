defmodule JwtRevocationRulesElixir.Rule do
  alias __MODULE__
  alias JwtRevocationRulesElixir.Condition
  alias JwtRevocationRulesElixir.Claims

  @spec __struct__ :: %Rule{
          aud: [%Condition{}],
          exp: [%Condition{}],
          iat: [%Condition{}],
          iss: [%Condition{}],
          jti: [%Condition{}],
          nbf: [%Condition{}],
          rule_expires: integer(),
          rule_id: bitstring() | nil,
          sub: [%Condition{}]
        }
  @doc """
  Defines a list of conditions for each claim.  The rule is met if all the conditions are met by the respective claims.
  """
  @enforce_keys [:rule_expires]
  defstruct [:rule_id, rule_expires: 0, iss: [], sub: [], aud: [],exp: [], nbf: [], iat: [], jti: []]


  @doc """
  Returns a condition of the `rule` the `claims` do not meet, or `nil` if they meet all the conditions
  """
  @spec is_not_met_by(rule :: %Rule{}, claims :: %Claims{}) :: %Rule{} | nil
  def is_not_met_by(%Rule{} = rule, %Claims{} = claims) do
    cond do
      match = Enum.find(rule.iss, &(!Condition.is_met(&1, claims.iss))) -> match
      match = Enum.find(rule.sub, &(!Condition.is_met(&1, claims.sub))) -> match
      match = Enum.find(rule.aud, &(!Condition.is_met(&1, claims.aud))) -> match
      match = Enum.find(rule.exp, &(!Condition.is_met(&1, claims.exp))) -> match
      match = Enum.find(rule.nbf, &(!Condition.is_met(&1, claims.nbf))) -> match
      match = Enum.find(rule.iat, &(!Condition.is_met(&1, claims.iat))) -> match
      match = Enum.find(rule.jti, &(!Condition.is_met(&1, claims.jti))) -> match
      true -> nil
    end
  end

  @doc """
  Returns if the `rule` is met by the `claims`
  """
  @spec is_met(rule :: %Rule{}, claims :: %Claims{}) :: boolean()
  def is_met(%Rule{} = rule, claims) do
    is_not_met_by(rule, claims) == nil
  end
end
