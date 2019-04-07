note
	description: "Summary description for {TYPE_CHECKER}."
	author: "Jackie and You"
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_CHECKER

inherit
	VISITOR

create
	make

feature -- Status
	is_type_correct: BOOLEAN

feature -- Constructor
	make
		do
			is_type_correct := false
		end

feature -- easy format

	end_with_numerical_type (e : EXPRESSION)
		local
			type_cal : TYPE_CALCULATOR
		do
			create type_cal.make
			e.accept (type_cal)
			if
				attached {NUMERICAL_TYPE} type_cal.type
			then
				is_type_correct := true
			end
		end

	end_with_boolean_type (e : EXPRESSION)
		local
			type_cal : TYPE_CALCULATOR
		do
			create type_cal.make
			e.accept (type_cal)
			if
				attached {BOOLEAN_TYPE} type_cal.type
			then
				is_type_correct := true
			end
		end


	end_with_numerical_or_boolean_type (e : EXPRESSION)
		local
			type_cal : TYPE_CALCULATOR
		do
			create type_cal.make
			e.accept (type_cal)
			if
				attached {NUMERICAL_TYPE} type_cal.type or attached {BOOLEAN_TYPE} type_cal.type
			then
				is_type_correct := true
			end
		end


feature -- To Do: Implement Commands for visiting composite structure

	visit_value_constant (e: VALUE_CONSTANT)
		do
			end_with_numerical_type(e)
		end

	visit_addition (e: ADDITION)
		do
			end_with_numerical_type(e)
		end

	visit_subtraction (e: SUBTRACTION)
		do
			end_with_numerical_type(e)
		end

	visit_multiplication (e: MULTIPLICATION)
		do
			end_with_numerical_type(e)
		end

	visit_division (e: DIVISION)
		do
			end_with_numerical_type(e)
		end

	visit_equals (e: EQUALS)
		do
			end_with_numerical_or_boolean_type(e)
		end

	visit_not_equals (e: NOT_EQUALS)
		do
			end_with_numerical_or_boolean_type(e)
		end

	visit_greater_than (e: GREATER_THAN)
		do
			end_with_boolean_type(e)
		end

	visit_greater_than_or_equals (e: GREATER_THAN_OR_EQUALS)
		do
			end_with_boolean_type(e)
		end

	visit_less_than (e: LESS_THAN)
		do
			end_with_boolean_type(e)
		end

	visit_less_than_or_equals (e: LESS_THAN_OR_EQUALS)
		do
			end_with_boolean_type(e)
		end

	visit_conjunction (e: CONJUNCTION)
		do
			end_with_boolean_type(e)
		end

	visit_disjunction (e: DISJUNCTION)
		do
			end_with_boolean_type(e)
		end

	visit_implication (e: IMPLICATION)
		do
			end_with_boolean_type(e)
		end

	visit_iff (e: IFF)
		do
			end_with_boolean_type(e)
		end

	visit_negation (e: NEGATION)
		do
			end_with_boolean_type(e)
		end

end
