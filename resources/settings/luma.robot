*** Settings ***
Resource        resources/keywords/common.robot
Resource        resources/keywords/luma.robot
Resource        resources/locators/luma.robot
Library         libraries/csv_keywords.py
Variables       data_variables/common_config.py
Variables       data_variables/luma/config.py
