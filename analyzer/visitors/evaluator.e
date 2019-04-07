note
	description: "Summary description for {EVALUATOR}."
	author: "Jackie and You"
	date: "$Date$"
	revision: "$Revision$"

class
	EVALUATOR

inherit
	VISITOR

create
	make

feature -- Status
	value: EXPRESSION_VALUE

feature -- Constructor
	make
		do
			create {NIL} value
		end

feature {NONE} -- Helper Queries

	is_equal_within (expected, actual: REAL_64): BOOLEAN
			-- Is `expected' equal to `actual' within 0.001 tolerance?
		do
			Result := (expected - actual).abs <= 0.001
		end

feature -- To Do: Implement Commands for visiting composite structure

	visit_value_constant (e: VALUE_CONSTANT)
		do
			value := create {NUMERICAL_VALUE}.make (e.value)
		end

	visit_addition (e: ADDITION)
		local
			e_left, e_right : EVALUATOR
			checker : TYPE_CHECKER
		do
			create e_left.make
			create e_right.make
			create checker.make
			e.accept (checker)
			if
				checker.is_type_correct
			then
				e.left.accept (e_left)
				e.right.accept (e_right)
				check attached {NUMERICAL_VALUE} e_left.value as l and then attached {NUMERICAL_VALUE} e_right.value as r then
				value := create {NUMERICAL_VALUE}.make (l.value + r.value) end
			end

		end

	visit_subtraction (e: SUBTRACTION)
		local
			e_left, e_right : EVALUATOR
			checker : TYPE_CHECKER
		do
			create e_left.make
			create e_right.make
			create checker.make
			e.accept (checker)
			if
				checker.is_type_correct
			then
				e.left.accept (e_left)
				e.right.accept (e_right)
				check attached {NUMERICAL_VALUE} e_left.value as l and then attached {NUMERICAL_VALUE} e_right.value as r then
				value := create {NUMERICAL_VALUE}.make (l.value - r.value) end
			end

		end

	visit_multiplication (e: MULTIPLICATION)
		local
			e_left, e_right : EVALUATOR
			checker : TYPE_CHECKER
		do
			create e_left.make
			create e_right.make
			create checker.make
			e.accept (checker)
			if
				checker.is_type_correct
			then
				e.left.accept (e_left)
				e.right.accept (e_right)
				check attached {NUMERICAL_VALUE} e_left.value as l and then attached {NUMERICAL_VALUE} e_right.value as r then
				value := create {NUMERICAL_VALUE}.make (l.value * r.value) end
			end

		end

	visit_division (e: DIVISION)
		local
			e_left, e_right : EVALUATOR
			checker : TYPE_CHECKER
		do
			create e_left.make
			create e_right.make
			create checker.make
			e.accept (checker)
			if
				checker.is_type_correct
			then
				e.left.accept (e_left)
				e.right.accept (e_right)
				check attached {NUMERICAL_VALUE} e_left.value as l and then attached {NUMERICAL_VALUE} e_right.value as r then
					if
						r.value = 0
					then
						value := create {NIL}.default_create
					else
						value := create {NUMERICAL_VALUE}.make (l.value / r.value)
					end
				end
			end

		end

	visit_equals (e: EQUALS)
		local
			e_left, e_right : EVALUATOR
			checker : TYPE_CHECKER
		do
			create e_left.make
			create e_right.make
			create checker.make
			e.accept (checker)
			if
				checker.is_type_correct
			then
				e.left.accept (e_left)
				e.right.accept (e_right)
				if attached {NUMERICAL_VALUE} e_left.value as l and then attached {NUMERICAL_VALUE} e_right.value as r then
					value := create {BOOLEAN_VALUE}.make (is_equal_within(l.value, r.value))
				elseif attached {BOOLEAN_VALUE} e_left.value as l and then attached {BOOLEAN_VALUE} e_right.value as r then
					value := create {BOOLEAN_VALUE}.make (l.value = r.value)
				end
			end

		end

	visit_not_equals (e: NOT_EQUALS)
		local
			e_left, e_right : EVALUATOR
			checker : TYPE_CHECKER
		do
			create e_left.make
			create e_right.make
			create checker.make
			e.accept (checker)
			if
				checker.is_type_correct
			then
				e.left.accept (e_left)
				e.right.accept (e_right)
				if attached {NUMERICAL_VALUE} e_left.value as l and then attached {NUMERICAL_VALUE} e_right.value as r then
					value := create {BOOLEAN_VALUE}.make (not is_equal_within(l.value, r.value))
				elseif attached {BOOLEAN_VALUE} e_left.value as l and then attached {BOOLEAN_VALUE} e_right.value as r then
					value := create {BOOLEAN_VALUE}.make (l.value /= r.value)
				end
			end

		end


	visit_greater_than (e: GREATER_THAN)
		local
			e_left, e_right : EVALUATOR
			checker : TYPE_CHECKER
		do
			create e_left.make
			create e_right.make
			create checker.make
			e.accept (checker)
			if
				checker.is_type_correct
			then
				e.left.accept (e_left)
				e.right.accept (e_right)
				check attached {NUMERICAL_VALUE} e_left.value as l and then attached {NUMERICAL_VALUE} e_right.value as r then
				value := create {BOOLEAN_VALUE}.make (l.value > r.value) end
			end

		end

	visit_greater_than_or_equals (e: GREATER_THAN_OR_EQUALS)
		local
			e_left, e_right : EVALUATOR
			checker : TYPE_CHECKER
		do
			create e_left.make
			create e_right.make
			create checker.make
			e.accept (checker)
			if
				checker.is_type_correct
			then
				e.left.accept (e_left)
				e.right.accept (e_right)
				check attached {NUMERICAL_VALUE} e_left.value as l and then attached {NUMERICAL_VALUE} e_right.value as r then
				value := create {BOOLEAN_VALUE}.make (l.value >= r.value) end
			end

		end
	visit_less_than (e: LESS_THAN)
		local
			e_left, e_right : EVALUATOR
			checker : TYPE_CHECKER
		do
			create e_left.make
			create e_right.make
			create checker.make
			e.accept (checker)
			if
				checker.is_type_correct
			then
				e.left.accept (e_left)
				e.right.accept (e_right)
				check attached {NUMERICAL_VALUE} e_left.value as l and then attached {NUMERICAL_VALUE} e_right.value as r then
				value := create {BOOLEAN_VALUE}.make (l.value < r.value) end
			end

		end

	visit_less_than_or_equals (e: LESS_THAN_OR_EQUALS)
		local
			e_left, e_right : EVALUATOR
			checker : TYPE_CHECKER
		do
			create e_left.make
			create e_right.make
			create checker.make
			e.accept (checker)
			if
				checker.is_type_correct
			then
				e.left.accept (e_left)
				e.right.accept (e_right)
				check attached {NUMERICAL_VALUE} e_left.value as l and then attached {NUMERICAL_VALUE} e_right.value as r then
				value := create {BOOLEAN_VALUE}.make (l.value <= r.value) end
			end

		end

	visit_conjunction (e: CONJUNCTION)
		local
			e_left, e_right : EVALUATOR
			checker : TYPE_CHECKER
		do
			create e_left.make
			create e_right.make
			create checker.make
			e.accept (checker)
			if
				checker.is_type_correct
			then
				e.left.accept (e_left)
				e.right.accept (e_right)
				check attached {BOOLEAN_VALUE} e_left.value as l and then attached {BOOLEAN_VALUE} e_right.value as r then
				value := create {BOOLEAN_VALUE}.make (l.value AND r.value) end
			end

		end

	visit_disjunction (e: DISJUNCTION)
		local
			e_left, e_right : EVALUATOR
			checker : TYPE_CHECKER
		do
			create e_left.make
			create e_right.make
			create checker.make
			e.accept (checker)
			if
				checker.is_type_correct
			then
				e.left.accept (e_left)
				e.right.accept (e_right)
				check attached {BOOLEAN_VALUE} e_left.value as l and then attached {BOOLEAN_VALUE} e_right.value as r then
				value := create {BOOLEAN_VALUE}.make (l.value OR r.value) end
			end

		end

	visit_implication (e: IMPLICATION)
		local
			e_left, e_right : EVALUATOR
			checker : TYPE_CHECKER
		do
			create e_left.make
			create e_right.make
			create checker.make
			e.accept (checker)
			if
				checker.is_type_correct
			then
				e.left.accept (e_left)
				e.right.accept (e_right)
				check attached {BOOLEAN_VALUE} e_left.value as l and then attached {BOOLEAN_VALUE} e_right.value as r then
				value := create {BOOLEAN_VALUE}.make (l.value implies r.value) end
			end

		end

	visit_iff (e: IFF)
		local
			e_left, e_right : EVALUATOR
			checker : TYPE_CHECKER
		do
			create e_left.make
			create e_right.make
			create checker.make
			e.accept (checker)
			if
				checker.is_type_correct
			then
				e.left.accept (e_left)
				e.right.accept (e_right)
				check attached {BOOLEAN_VALUE} e_left.value as l and then attached {BOOLEAN_VALUE} e_right.value as r then
				value := create {BOOLEAN_VALUE}.make ((l.value implies r.value) and (r.value implies l.value)) end
			end

		end

	visit_negation (e: NEGATION)
		local
			e_expr: EVALUATOR
			checker : TYPE_CHECKER
		do
			create e_expr.make
			create checker.make
			e.accept (checker)
			if
				checker.is_type_correct
			then
				e.expr.accept (e_expr)
				check attached {BOOLEAN_VALUE} e_expr.value as expr then
				value := create {BOOLEAN_VALUE}.make (not expr.value) end
			end

		end


end
