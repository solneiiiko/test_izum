require_relative 'split_str_by_length'
require 'test/unit'

class TestSplitStrByLength < Test::Unit::TestCase
  def test_nil
    assert_equal( split_str_by_length(nil, 1), [])
  end

  def test_empty
    assert_equal( split_str_by_length("", 1), [])
  end

  def test_min_count
    str = 'To be or not to be-that is the question'
    assert_equal( split_str_by_length(str, 0), [])
  end

  def test_example
    str = 'To be or not to be-that is the question'
    assert_equal( split_str_by_length(str, 5), ['To be','or','not','to be','-that','is','the','quest','ion'])
  end

  def test_long_word
    str = 'Question? Questions!'
    assert_equal( split_str_by_length(str, 5), ['Quest','ion?','Quest','ions!'])
  end

  def test_long_word_and_small_count
    str = 'Question? Questions!'
    assert_equal( split_str_by_length(str, 1), %w(Q u e s t i o n ? Q u e s t i o n s !) )
  end

  def test_big_count
    str = 'To be or not to be-that is the question'
    assert_equal( split_str_by_length(str, str.size), [str])
  end

  def test_big_count_minus_1
    str = 'To be or not to be-that is the question'
    assert_equal( split_str_by_length(str, str.size-1), ['To be or not to be-that is the', 'question'])
  end

  def test_big_count_plus_1
    str = 'To be or not to be-that is the question'
    assert_equal( split_str_by_length(str, str.size+1), ['To be or not to be-that is the question'])
  end

end