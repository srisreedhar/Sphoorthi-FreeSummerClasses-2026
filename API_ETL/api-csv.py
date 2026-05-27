# API -> CSV
# https://fakestoreapi.com/products

import requests
import pandas as pd

# Fake API URL
url = "https://fakestoreapi.com/products"

response = requests.get(url)
data = response.json()

df = pd.DataFrame(data)
df = df[['id', 'title', 'price', 'category']]

# column - renaming
df.columns = [
    'order_id',
    'product_name',
    'price',
    'city']

# few extra columns
df['customer_name'] = 'Guest User'
df['quantity'] = 1
df['order_date'] = '2025-01-01'

# Rearranging columns
df = df[
    [
        'order_id',
        'customer_name',
        'city',
        'product_name',
        'quantity',
        'price',
        'order_date'
    ]
]

# Save CSV
df.to_csv('orders_data.csv', index=False)
print("CSV file created successfully")