note
	description: "Summary description for {TYPE_CALCULATOR}."
	author: "Jackie and You"
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_CALCULATOR

inherit
	VISITOR

create

	make

feature -- Status

	type: EXPRESSION_TYPE

feature -- Constructor

	make
		do
			create {UNKNOWN_TYPE} type
		end

feature -- easy format

	visit_numerical_to_numberical_type (e : BINARY_EXPRESSION)
		local
			l_cal, r_cal: TYPE_CALCULATOR
		do
			create l_cal.make
			create r_cal.make
			e.left.accept (l_cal)
			e.right.accept (r_cal)
			if
				attached {NUMERICAL_TYPE} l_cal.type and attached {NUMERICAL_TYPE} r_cal.type
			then
				type:= create {NUMERICAL_TYPE}.default_create
			else
				type:= create {UNKNOWN_TYPE}.default_create
			end
		end


	visit_numerical_to_boolean_type (e : BINARY_EXPRESSION)
		local
			l_cal, r_cal: TYPE_CALCULATOR
		do
			create l_cal.make
			create r_cal.make
			e.left.accept (l_cal)
			e.right.accept (r_cal)
			if
				attached {NUMERICAL_TYPE} l_cal.type and attached {NUMERICAL_TYPE} r_cal.type
			then
				type:= create {BOOLEAN_TYPE}.default_create
			else
				type:= create {UNKNOWN_TYPE}.default_create
			end
		end


	visit_boolean_to_boolean_type (e : BINARY_EXPRESSION)
	local
			l_cal, r_cal: TYPE_CALCULATOR
		do
			create l_cal.make
			create r_cal.make
			e.left.accept (l_cal)
			e.right.accept (r_cal)
			if
				attached {BOOLEAN_TYPE} l_cal.type and attached {BOOLEAN_TYPE} r_cal.type
			then
				type:= create {BOOLEAN_TYPE}.default_create
			else
				type:= create {UNKNOWN_TYPE}.default_create
			end
		end

	visit_numerical_or_boolean_to_boolean_type (e : BINARY_EXPRESSION)
		local
			l_cal, r_cal: TYPE_CALCULATOR
		do
			create l_cal.make
			create r_cal.make
			e.left.accept (l_cal)
			e.right.accept (r_cal)
			if
				(attached {NUMERICAL_TYPE} l_cal.type and attached {NUMERICAL_TYPE} r_cal.type) or
				(attached {BOOLEAN_TYPE} l_cal.type and attached {BOOLEAN_TYPE} r_cal.type)
			then
				type:= create {BOOLEAN_TYPE}.default_create
			else
				type:= create {UNKNOWN_TYPE}.default_create
			end
		end


	unary_visit_boolean_to_boolean_type (e : UNARY_EXPRESSION)
		local
			e_cal: TYPE_CALCULATOR
		do
			create e_cal.make
			e.expr.accept (e_cal)
			if
				attached {BOOLEAN_TYPE} e_cal.type
			then
				type:= create {BOOLEAN_TYPE}.default_create
			else
				type:= create {UNKNOWN_TYPE}.default_create
			end
		end


feature -- To Do: Implement Commands for visiting composite structure

	visit_value_constant (e: VALUE_CONSTANT)
		do
			type:= create {NUMERICAL_TYPE}.default_create
		end

	visit_addition (e: ADDITION)
		do
			visit_numerical_to_numberical_type(e)
		end

	visit_subtraction (e: SUBTRACTION)
		do
			visit_numerical_to_numberical_type(e)
		end

	visit_multiplication (e: MULTIPLICATION)
		do
			visit_numerical_to_numberical_type(e)
		end

	visit_division (e: DIVISION)
		do
			visit_numerical_to_numberical_type(e)
		end

	visit_equals (e: EQUALS)
		do
			visit_numerical_or_boolean_to_boolean_type(e)
		end

	visit_not_equals (e: NOT_EQUALS)
		do
			visit_numerical_or_boolean_to_boolean_type(e)
		end

	visit_greater_than (e: GREATER_THAN)
		do
			visit_numerical_to_boolean_type(e)
		end

	visit_greater_than_or_equals (e: GREATER_THAN_OR_EQUALS)
		do
			visit_numerical_to_boolean_type(e)
		end

	visit_less_than (e: LESS_THAN)
		do
			visit_numerical_to_boolean_type(e)
		end

	visit_less_than_or_equals (e: LESS_THAN_OR_EQUALS)
		do
			visit_numerical_to_boolean_type(e)
		end

	visit_conjunction (e: CONJUNCTION)
		do
			visit_boolean_to_boolean_type(e)
		end

	visit_disjunction (e: DISJUNCTION)
		do
			visit_boolean_to_boolean_type(e)
		end

	visit_implication (e: IMPLICATION)
		do
			visit_boolean_to_boolean_type(e)
		end

	visit_iff (e: IFF)
		do
			visit_boolean_to_boolean_type(e)
		end

	visit_negation (e: NEGATION)
		do
			unary_visit_boolean_to_boolean_type(e)
		end

end
