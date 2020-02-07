class TestInvalidSensSms < Minitest::Test
  def teardown
    return unless SensSms::Client.class_variable_defined? :@@access_key

    SensSms::Client.remove_class_variable :@@access_key
    SensSms::Client.remove_class_variable :@@service_id
    SensSms::Client.remove_class_variable :@@secret_key
  end

  def test_validating_configure
    assert_raises(RuntimeError) do
      SensSms::Client.new
    end
  end
end
