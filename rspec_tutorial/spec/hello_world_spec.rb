
class HelloWorld

  def say_hello
    "Hello Worlas!"
  end

end

describe HelloWorld do
  context 'When testing the HelloWorld class' do

    it "should say 'Hello World' when we call the say_hello method" do
      hw = HelloWorld.new
      message = hw.say_hello
      expect(message).to eq "Hello World!"
    end

  end
end