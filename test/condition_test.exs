defmodule ConditionTest do
  use ExUnit.Case
  alias JwtRevocationRulesElixir.Condition

  test "test != condition" do
    string_condition = %Condition{
      operation: :!=,
      value: "match"
    }
    assert !Condition.is_met(string_condition, string_condition.value)
    assert Condition.is_met(string_condition, "not match")
    assert Condition.is_met(string_condition, nil)

    integer_condition = %Condition{
      operation: :!=,
      value: 1234
    }
    assert !Condition.is_met(integer_condition, integer_condition.value)
    assert Condition.is_met(integer_condition, 4321)
    assert Condition.is_met(integer_condition, nil)

    nil_condition = %Condition{
      operation: :!=,
      value: nil
    }
    assert !Condition.is_met(nil_condition, nil_condition.value)
    assert Condition.is_met(nil_condition, "not match")
    assert Condition.is_met(nil_condition, 1234)
    assert !Condition.is_met(nil_condition, nil)
  end

  test "test = condition" do
    string_condition = %Condition{
      operation: :=,
      value: "match"
    }
    assert Condition.is_met(string_condition, string_condition.value)
    assert !Condition.is_met(string_condition, "not match")
    assert !Condition.is_met(string_condition, nil)

    integer_condition = %Condition{
      operation: :=,
      value: 1234
    }
    assert Condition.is_met(integer_condition, integer_condition.value)
    assert !Condition.is_met(integer_condition, 4321)
    assert !Condition.is_met(integer_condition, nil)

    nil_condition = %Condition{
      operation: :=,
      value: nil
    }
    assert Condition.is_met(nil_condition, nil_condition.value)
    assert !Condition.is_met(nil_condition, "not match")
    assert !Condition.is_met(nil_condition, 1234)
    assert Condition.is_met(nil_condition, nil)
  end
end
