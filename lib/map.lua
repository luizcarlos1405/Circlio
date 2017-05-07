function map(value, input_min, input_max, output_min, output_max)
	return (value - input_min) * (output_max - output_min) / (input_max - input_min) + output_min
end
