require 'spec_helper'

describe League do
  describe 'Check for create_league' do
    it 'There should be an create_league method in League model' do
      League.should respond_to :create_league!
      end
   end
end
