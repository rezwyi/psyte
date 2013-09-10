require 'spec_helper'

describe ApplicationHelper do
  describe '#render_markdown' do
    it 'should render some html' do
      helper.render_markdown('#header').should eq("<h1>header</h1>\n")
    end

    it 'should render some html' do
      helper.render_markdown('*bold*').should eq("<p><em>bold</em></p>\n")
    end

    it 'should filter script tag' do
      helper.render_markdown('<script></script>').should be_empty
    end

    it 'should filter iframe tag' do
      helper.render_markdown('<iframe></iframe>').should be_empty
    end
  end

  describe '#formated_project_url' do
    it 'should not change url' do
      helper.format_project_url('test.com').should == 'test.com'
    end

    it 'should cut http:// in the beginning' do
      helper.format_project_url('http://test.com').should == 'test.com'
    end

    it 'should cut http:// in the beginning' do
      helper.format_project_url('   http://test.com   ').should == 'test.com'
    end
  end
end