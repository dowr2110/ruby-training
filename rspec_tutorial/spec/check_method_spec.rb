def NewMethod(a, b)
  return a * b
end

describe 'description' do

    it 'should be return sum of parameters a and b' do
      a = 5
      b = 8
      sum = NewMethod(a , b)
      expect(sum).to eq a + b
    end

end