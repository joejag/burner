require 'spec_helper'
require 'simple_linear_progression'

describe SimpleLinearRegression do

    context "real data from 24+" do
        let(:done_line) { SimpleLinearRegression.new([0, 1, 2, 3, 4 ,5], [51, 103, 129, 218, 150, 217]) }
        let(:scope_line) { SimpleLinearRegression.new([0, 1, 2, 3, 4 ,5], [312, 292, 312, 331, 406, 387]) }

        context "simple linear regression" do
            it "should find the slope of the done_line" do
                done_line.slope.to_i.should eq 30
            end
            it "should find the y_intercept of the done_line" do
                done_line.y_intercept.to_i.should eq 68
            end
        end

        context "comparing two lines" do
            it "should find the y intersect of 24+" do
                SimpleLinearRegression.get_x_intersection(done_line, scope_line).to_i.should eq 23
            end
            it "should find the x intersect of 24+" do
                SimpleLinearRegression.get_y_intersection(done_line, scope_line).to_i.should eq 783
            end
        end
    end

end
