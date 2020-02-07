class TestInvalidSensSms < Minitest::Test
  def test_validating_configure
    assert_raises(RuntimeError) do
      SensSms::Client.new
    end
  end
end
