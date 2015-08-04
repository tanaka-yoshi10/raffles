require 'rails_helper'

describe Project do
  describe '#code_and_name' do
    it 'returns code and name' do
      project = create(:project,
        name: 'name',
        code: 'code'
      )
      expect(project.code_and_name).to eq('code name')
    end
  end
end