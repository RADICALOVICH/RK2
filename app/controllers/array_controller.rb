# frozen_string_literal: true

# our controller
class ArrayController < ApplicationController
  before_action :parameters, only: :result
  before_action :validation, only: :result
  def input; end

  def result
    @sum = sum(@array)
    @result_array = @array.clone
    @result_array[-2] = @sum if @result_array.size.even?
    @result_array[-1] = @sum if @result_array.size.odd?
  end

  def parameters
    @string_array = params[:input]
    @array = @string_array.split.map(&:to_f)
  end

  private

  def validation
    redirect_to home_path, alert: 'Вводите только вещественные числа через пробел' if
    @string_array.match(/^( ?)+(-?\d+(\.\d+)?)((?:\ +(-?\d+(\.\d+)?))+)?(\ +)?$/).nil?
  end

  def sum(array)
    array.select { |n| (n % 3).zero? }.sum
  end

  def insert_sum(sum, array)
    array[-2] = sum if array.size.even?
    array[-1] = sum if array.size.odd?
    array
  end
end
