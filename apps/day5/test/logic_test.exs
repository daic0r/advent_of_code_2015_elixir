defmodule LogicTest do
  use ExUnit.Case
  doctest Day5.Logic

  alias Day5.Logic

  test "is a vowel" do
    assert Logic.is_vowel?("a")
    assert Logic.is_vowel?("e")
    assert Logic.is_vowel?("i")
    assert Logic.is_vowel?("o")
    assert Logic.is_vowel?("u")

    assert !Logic.is_vowel?("b")
    assert !Logic.is_vowel?("c")
    assert !Logic.is_vowel?("d")
    assert !Logic.is_vowel?("f")
    assert !Logic.is_vowel?("g")
    assert !Logic.is_vowel?("h")
    assert !Logic.is_vowel?("j")
    assert !Logic.is_vowel?("k")
    assert !Logic.is_vowel?("l")
    assert !Logic.is_vowel?("m")
    assert !Logic.is_vowel?("n")
    assert !Logic.is_vowel?("p")
    assert !Logic.is_vowel?("q")
    assert !Logic.is_vowel?("r")
    assert !Logic.is_vowel?("s")
    assert !Logic.is_vowel?("t")
    assert !Logic.is_vowel?("v")
    assert !Logic.is_vowel?("w")
    assert !Logic.is_vowel?("x")
    assert !Logic.is_vowel?("y")
    assert !Logic.is_vowel?("z")
  end

  test "has disallowed pair" do
    assert Logic.has_disallowed_pair?("haegwjzuvuyypxyu")
    assert Logic.has_disallowed_pair?("abcdefg")
    assert Logic.has_disallowed_pair?("cdefg")
    assert Logic.has_disallowed_pair?("fiudshfpqhfksajf")

    assert !Logic.has_disallowed_pair?("fhfkjdsfkds")
  end

  test "has double letter" do
    assert Logic.has_double_letter("fsfhdfhhsfc")
    assert Logic.has_double_letter("aafdsjfhdsf")

    assert !Logic.has_double_letter("abcdefg")
  end

  test "has 2 letter pairs" do
    assert not Logic.has_2_letter_pairs?("abba")
    assert not Logic.has_2_letter_pairs?("abbba")
    assert Logic.has_2_letter_pairs?("abbbabba")
  end

  test "is nice part 2" do
    assert Logic.is_nice_part_2?("qjhvhtzxzqqjkmpb")
    assert Logic.is_nice_part_2?("xxyxx")
    assert not Logic.is_nice_part_2?("uurcxstgmygtbstg")
    assert not Logic.is_nice_part_2?("ieodomkazucvgmuy")
  end
end
