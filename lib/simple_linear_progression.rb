# Taken from https://gist.github.com/rweald/3517406
# Explaination at: http://engineering.sharethrough.com/blog/2012/09/12/simple-linear-regression-using-ruby/
class SimpleLinearRegression

  def initialize(xs, ys)
    @xs, @ys = xs, ys
    if @xs.length != @ys.length
      raise "Unbalanced data. xs need to be same length as ys"
    end
  end

  def y_intercept
    mean(@ys) - (slope * mean(@xs))
  end

  def slope
    x_mean = mean(@xs)
    y_mean = mean(@ys)

    numerator = (0...@xs.length).reduce(0) do |sum, i|
      sum + ((@xs[i] - x_mean) * (@ys[i] - y_mean))
    end

    denominator = @xs.reduce(0) do |sum, x|
      sum + ((x - x_mean) ** 2)
    end

    (numerator / denominator)
  end

  def mean(values)
    total = values.reduce(0) { |sum, x| x + sum }
    Float(total) / Float(values.length)
  end

  def self.get_x_intersection(line1, line2)
    (line1.y_intercept - line2.y_intercept) / (line2.slope - line1.slope)
  end

  def self.get_y_intersection(line1, line2)
    ((line2.slope * (line1.y_intercept - line2.y_intercept)) / (line2.slope - line1.slope)) + line2.y_intercept
  end

end

