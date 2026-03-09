from datetime import date
import pytest
from pytest_bdd import scenarios, given, when, then, parsers

from core.expense_service import ExpenseService
from core.in_memory_expense_repository import InMemoryExpenseRepository

scenarios("./expense_management.feature")


@pytest.fixture
def context():
    repo = InMemoryExpenseRepository()
    service = ExpenseService(repo)
    return {"service": service, "db": repo}


@given(parsers.parse("un gestor de gastos vacío"))
def empty_manager(context):
    pass


@given(parsers.parse("un gestor con un gasto de {amount:d} euros"))
def manager_with_one_expense(context, amount):
    context["service"].create_expense(
        title="Gasto inicial", amount=amount, description="", expense_date=date.today()
    )


@when(parsers.parse("añado un gasto de {amount:d} euros llamado {title}"))
def add_expense(context, amount, title):
    context["service"].create_expense(
        title=title, amount=amount, description="", expense_date=date.today()
    )


@when(parsers.parse("elimino el gasto con id {expense_id:d}"))
def remove_expense(context, expense_id):
    context["service"].remove_expense(expense_id)


@then(parsers.parse("el total de dinero gastado debe ser {total:d} euros"))
def check_total(context, total):
    assert context["service"].total_amount() == total


@then(parsers.parse("debe haber {expenses:d} gastos registrados"))
def check_expenses_length(context, expenses):
    total = len(context["db"]._expenses)
    assert expenses == total


# BONUS


@when(
    parsers.parse('actualizo el titulo del gasto con id {expense_id:d} a "{new_title}"')
)
def update_expense_title(context, expense_id, new_title):
    context["service"].update_expense(expense_id=expense_id, title=new_title)


@then(
    parsers.parse(
        'el titulo del gasto con id {expense_id:d} debe ser "{expected_title}"'
    )
)
def check_expense_title(context, expense_id, expected_title):
    expense = context["db"].get_by_id(expense_id)
    assert expense.title == expected_title


@when(
    parsers.parse("actualizo el monto del gasto con id {expense_id:d} a {new_amount:d}")
)
def update_expense_amount(context, expense_id, new_amount):
    context["service"].update_expense(expense_id=expense_id, amount=new_amount)


@then(parsers.parse("el total del mes actual debe ser {expected_total:d} euros"))
def check_current_month_total(context, expected_total):
    totals_by_month = context["service"].total_by_month()
    current_month_key = date.today().strftime("%Y-%m")
    assert totals_by_month.get(current_month_key, 0) == expected_total
