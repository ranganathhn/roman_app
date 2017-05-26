class RomansController < ApplicationController
	before_filter :check_for_roman_and_calulate,  if: :is_calculate_present?

	def calculate
		respond_to do |format|
      format.js
      format.html
    end
	end

	private

	def check_for_roman_and_calulate
		roman_symbols = %w[I V X L C D M]
		@operand_1 = params[:operand_1]
		@operand_2 = params[:operand_2]
		@operator =  params[:operator]

		# check for empty hits
		if @operand_1.present? && @operand_2.present?
			#check for valid roman numbers
			unless ((@operand_1 + @operand_2).split('').uniq - roman_symbols).empty?
				redirect_to "/", notice: 'Please give valid roman numbers'
			else
				#calculation
				@operand_1 = @operand_1.from_roman_to_decimal
				@operand_2 = @operand_2.from_roman_to_decimal
				@result = (@operand_1.send(@operator,@operand_2)).to_roman
			end
		else
			redirect_to "/", notice: 'Please give inputs'
		end
	end

	def is_calculate_present?
		# if calulation params present do calculation
		params[:commit] == "Calculate" if params[:commit].present?
	end
end