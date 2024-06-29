from libraries.csv_dao import CsvRowDao


class DaoStore:
    def __init__(self):
        self.dao = {}

    def get_dao(self, name):
        if name in self.dao:
            return self.dao[name]

    def set_dao(self, name, dao):
        self.dao[name] = dao


DAO_STORE = DaoStore()
CUSTOMER_DAO = "Customer"


# A static library has all of its robot framework keywords defined as python functions ####
# Customer
def get_customer_from_csv(input_file: str):
    global DAO_STORE
    dao = CsvRowDao(input_file)
    DAO_STORE.set_dao(CUSTOMER_DAO, dao)
    customer = dao.get_csvrow_by_conditions(status="")
    if not customer:
        raise Exception(f"Sorry, no input data left in {input_file}")
    return customer


def update_status_in_customer(email: str, status: str):
    dao = DAO_STORE.get_dao(CUSTOMER_DAO)
    dao.update_status_by_email(email, status)


def update_orderid_in_customer(email: str, orderid: str):
    dao = DAO_STORE.get_dao(CUSTOMER_DAO)
    dao.update_orderid_by_email(email, orderid)
