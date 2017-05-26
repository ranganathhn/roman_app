class RomansController < ApplicationController
	before_filter :check_for_roman, only: [:calculate]

	def index
		
	end

	def calculate
		result = @operand_1.send(@operator,@operand_2)
		debugger
	end

	private

	def check_for_roman
		roman_symbols = %w[I V X L C D M]
		@operand_1 = params[:operand_1]
		@operand_2 = params[:operand_2]
		@operator =  params[:operator]
		if @operand_1.present? && @operand_2.present?
			unless ((@operand_1 + @operand_2).split('').uniq - roman_symbols).empty?
				redirect_to "/", notice: 'Please give valid roman numbers'
			else
				@operand_1 = @operand_1.from_roman_to_decimal
				@operand_2 = @operand_2.from_roman_to_decimal
			end
		else
			redirect_to "/", notice: 'Please give inputs'
		end
	end

	
end