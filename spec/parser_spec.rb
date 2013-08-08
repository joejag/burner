require 'spec_helper'
require 'parser'
require 'persistence'

describe Parser do

    before do
      ProjectStatus.create(project: 'my project', team: 't', done: 1, scoped: 5, status_at: time)
      ProjectStatus.create(project: 'my project', team: 't', done: 2, scoped: 5, status_at: time + 1.day)
    end

    let(:subject) { Parser.new('my project') }
    let(:time) { Time.now }

    context "returning the full set of lines" do
        let(:lines) { subject.lines }
        it "it should have a done line" do
           lines.any? { |e| e[:name] == 'Done'}.should be_true
        end
        it "it should have a scoped line" do
           lines.any? { |e| e[:name] == 'Scoped'}.should be_true
        end
    end

    context "converting database records into two charts" do
        it "should have a line with x and y points representing items complete and time" do
           done_line_data = subject.done_line[:data]
           done_line_data.size.should eql 2
           done_line_data[0][:x].should eql time.to_i
           done_line_data[0][:y].should eql 1
        end
    end

    context "creating the trend lines" do
        it "should make a scope trend line" do
            data = subject.scope_trend_line[:data]
            data.size.should eql 2
            data[0][:x].should eql time.to_i
            data[0][:y].to_i.should eql 5

            data[1][:x].to_i.should eql (time + 4.day).to_i
            data[1][:y].should eql 5
        end
    end

end

