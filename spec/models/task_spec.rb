# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  it 'é inválido sem uma URL' do
    task = Task.new(url: nil)
    expect(task).to_not be_valid
  end

  it 'é inválido sem um título' do
    task = Task.new(title: nil)
    expect(task).to_not be_valid
  end
end
