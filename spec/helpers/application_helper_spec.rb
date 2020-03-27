require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#full_title' do
    example 'nilだった時、basetitleのみ返すこと' do
      expect(full_title(nil)).to eq 'NoticeBoard'
    end

    example 'emptyだった時、basetitleのみ返すこと' do
      expect(full_title('')).to eq 'NoticeBoard'
    end

    example '正しいfulltitleを返すこと' do
      expect(full_title('Page')).to eq 'Page-NoticeBoard'
    end
  end
end
