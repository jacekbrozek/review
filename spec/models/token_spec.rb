require 'spec_helper'

describe Token do

  it { should respond_to(:tokenable) }
  it { should validate_uniqueness_of(:value) }

  describe "model methods" do
    let!(:project){ Project.create(name: 'something', url: 'http://test.com') }
    let!(:token){ project.tokens.first }

    context 'get_tokenable' do
      it 'returns nil if no token given' do
        expect(Token.get_tokenable nil).to eq(nil)
      end

      it 'returns nil if wrong token given' do
        expect(Token.get_tokenable 'wrong_token').to eq(nil)
      end

      it 'returns project if correct token given' do
        expect(Token.get_tokenable token.value).to eq(project)
      end
    end
  end
end
