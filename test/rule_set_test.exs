defmodule RuleSetTest do
  use ExUnit.Case
  alias JwtRevocationRulesElixir.Condition
  alias JwtRevocationRulesElixir.Rule
  alias JwtRevocationRulesElixir.Claims
  alias JwtRevocationRulesElixir.RuleSet

  test "test rule set matches when at least one rule matches" do
    iss_rule = %Rule{rule_expires: 1690726101, iss: [%Condition{operation: :=, value: "meets"}]}
    aud_rule = %Rule{rule_expires: 1690726101, aud: [%Condition{operation: :=, value: "meets"}]}

    ruleset = %RuleSet{timestamp: 1690726101, rules: [iss_rule, aud_rule]}

    claims_which_meet_neither = %Claims{iss: "does not meet", aud: "does not meet"}
    assert RuleSet.is_met_by(ruleset, claims_which_meet_neither) == nil
    assert !RuleSet.is_met(ruleset, claims_which_meet_neither)

    claims_which_meet_one =%Claims{
      iss: "does not meet",
      aud: "meets"
    }
    assert RuleSet.is_met_by(ruleset, claims_which_meet_one) == aud_rule
    assert RuleSet.is_met(ruleset, claims_which_meet_one)

    claims_which_meet_both =%Claims{
      iss: "does not meet",
      aud: "meets"
    }
    assert Enum.member?(ruleset.rules, RuleSet.is_met_by(ruleset, claims_which_meet_both))
    assert RuleSet.is_met(ruleset, claims_which_meet_both)
  end
end
