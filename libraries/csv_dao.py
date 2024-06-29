import csv


class CsvRow:
    Status = ''


class CsvRowDao:
    """
    This class helps to filter the CSV row by status or another condition, ...
    and then update it accordingly when used.
    """

    def __init__(self, csv_file: str):
        self.csv_file = csv_file

    def update_csvrow_by_rowidx(self, rowidx: int, col_name: str, col_data: str):
        """
        Update column data by row index
        """
        with open(self.csv_file, encoding='utf8') as f:
            all_rows_data = [row for row in csv.DictReader(f)]
            all_rows_data[rowidx][col_name] = col_data
            all_columns_data = all_rows_data[rowidx].keys()
        with open(self.csv_file, 'w', newline='', encoding='utf8') as f:
            writer = csv.DictWriter(f, fieldnames=all_columns_data)
            writer.writeheader()
            writer.writerows(all_rows_data)

    def set_csvrow_attributes(self, csv_row_items: dict):
        """
        Set class attributes by CSV headers,
         which does not to contain special characters and whitespaces.
        """
        csvrow = CsvRow()
        for key in csv_row_items.keys():
            csvrow.__setattr__(key, csv_row_items[key])
        return csvrow

    def get_csvrow_by_conditions(self, status: str = ''):
        csvrow = None
        with open(self.csv_file, encoding='utf8') as f:
            reader = csv.DictReader(f)
            for i, row in enumerate(reader):
                if row['Status'] == status:
                    self.update_csvrow_by_rowidx(i, 'Status', 'Selected')
                    csvrow = self.set_csvrow_attributes(row)
                    break
        return csvrow

    def get_csvrow_by_status(self, status: str):
        """
        Filter row by status from top to bottom and return CsvRow
        and then update it to 'Selected' accordingly.
        """
        csvrow = None
        with open(self.csv_file, encoding='utf8') as f:
            reader = csv.DictReader(f)
            for i, row in enumerate(reader):
                if row['Status'] == status:
                    self.update_csvrow_by_rowidx(i, 'Status', 'Selected')
                    csvrow = self.set_csvrow_attributes(row)
                    break
        return csvrow

    def update_status_by_email(self, email: str, status: str):
        """
        Update status by email
        """
        with open(self.csv_file, encoding='utf8') as f:
            reader = csv.DictReader(f)
            for i, row in enumerate(reader):
                if row['Email'] == email:
                    self.update_csvrow_by_rowidx(i, 'Status', status)
                    break

    def update_orderid_by_email(self, email: str, orderid: str):
        """
        Update orderid by email
        """
        with open(self.csv_file, encoding='utf8') as f:
            reader = csv.DictReader(f)
            for i, row in enumerate(reader):
                if row['Email'] == email:
                    self.update_csvrow_by_rowidx(i, 'OrderId', orderid)
                    break
