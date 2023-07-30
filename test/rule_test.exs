defmodule RuleTest do
  use ExUnit.Case
  alias JwtRevocationRulesElixir.Condition
  alias JwtRevocationRulesElixir.Rule
  alias JwtRevocationRulesElixir.Claims

  test "test rule with iss conditions" do
    condition = %Condition{operation: :=, value: "meets"}

    rule = %Rule{
      rule_expires: 1690674735,
      iss: [condition]
    }

    assert Rule.is_not_met_by(rule, %Claims{iss: "meets"}) == nil
    assert Rule.is_met(rule, %Claims{iss: "meets"})

    assert Rule.is_not_met_by(rule, %Claims{iss: "does not meet"}) == condition
    assert !Rule.is_met(rule, %Claims{iss: "does not meet"})
  end

  test "test rule with sub conditions" do
    condition = %Condition{operation: :=, value: "meets"}

    rule = %Rule{
      rule_expires: 1690674735,
      sub: [condition]
    }

    assert Rule.is_not_met_by(rule, %Claims{sub: "meets"}) == nil
    assert Rule.is_not_met_by(rule, %Claims{sub: "does not meet"}) == condition
  end

  test "test rule with aud conditions" do
    condition = %Condition{operation: :=, value: "meets"}

    rule = %Rule{
      rule_expires: 1690674735,
      aud: [condition]
    }

    assert Rule.is_not_met_by(rule, %Claims{aud: "meets"}) == nil
    assert Rule.is_not_met_by(rule, %Claims{aud: "does not meet"}) == condition
  end

  test "test rule with exp conditions" do
    condition = %Condition{operation: :=, value: 1690674735}

    rule = %Rule{
      rule_expires: 1690674735,
      exp: [condition]
    }

    assert Rule.is_not_met_by(rule, %Claims{exp: 1690674735}) == nil
    assert Rule.is_not_met_by(rule, %Claims{exp: 2690674735}) == condition
  end

  test "test rule with nbf conditions" do
    condition = %Condition{operation: :=, value: 1690674735}

    rule = %Rule{
      rule_expires: 1690674735,
      nbf: [condition]
    }

    assert Rule.is_not_met_by(rule, %Claims{nbf: 1690674735}) == nil
    assert Rule.is_not_met_by(rule, %Claims{nbf: 2690674735}) == condition
  end

  test "test rule with iat conditions" do
    condition = %Condition{operation: :=, value: 1690674735}

    rule = %Rule{
      rule_expires: 1690674735,
      iat: [condition]
    }

    assert Rule.is_not_met_by(rule, %Claims{iat: 1690674735}) == nil
    assert Rule.is_not_met_by(rule, %Claims{iat: 2690674735}) == condition
  end

  test "test rule with jti conditions" do
    condition = %Condition{operation: :=, value: "meets"}

    rule = %Rule{
      rule_expires: 1690674735,
      jti: [condition]
    }

    assert Rule.is_not_met_by(rule, %Claims{jti: "meets"}) == nil
    assert Rule.is_not_met_by(rule, %Claims{jti: "does not meet"}) == condition
  end

  test "test multiple conditions for the same claim must all be met" do
    rule = %Rule{
      rule_expires: 1690674735,
      iss: [
        %Condition{operation: :!=, value: "does not match 1"},
        %Condition{operation: :!=, value: "does not match 2"}
      ]
    }

    assert Rule.is_met(rule, %Claims{iss: "matches"})
    assert !Rule.is_met(rule, %Claims{iss: "does not match 1"})
    assert !Rule.is_met(rule, %Claims{iss: "does not match 2"})
  end

  test "test multiple conditions for different claims" do
    rule = %Rule{
      rule_expires: 1690674735,
      iss: [%Condition{operation: :=, value: "matches"}],
      aud: [%Condition{operation: :=, value: "matches"}]
    }

    assert Rule.is_met(rule, %Claims{iss: "matches", aud: "matches"})
    assert !Rule.is_met(rule, %Claims{iss: "does not match", aud: "matches"})
    assert !Rule.is_met(rule, %Claims{iss: "does not match", aud: "does not match"})
  end

end
