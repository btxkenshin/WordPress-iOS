require File.expand_path('../../spec_helper', __FILE__)

module Pod
  describe Command::Update do
    describe 'CLAide' do
      it 'registers it self' do
        Command.parse(%w{ update }).should.be.instance_of Command::Update
      end
    end
  end
end

