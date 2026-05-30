# install required packages before 
# run -> pip install faker pandas numpy

from faker import Faker
import pandas as pd
import random
from datetime import datetime
import numpy as np

fake = Faker('en_IN')

# Set seed for reproducibility
random.seed(42)
np.random.seed(42)
fake.seed_instance(42)

print("Generating enhanced E-commerce dataset...")

# ==================== CONFIGURATION ====================
num_rows = 1500
num_unique_customers = 380
num_unique_sellers = 25

customer_statuses = ['active', 'inactive', 'new', 'dormant']
order_statuses = ['fulfilled', 'returned', 'lost_parcel', 'processing']
payment_methods = ['Credit Card', 'UPI', 'Cash']

product_categories = [
    'Electronics', 'Fashion', 'Home & Kitchen', 'Beauty', 'Books', 
    'Sports', 'Toys & Games', 'Jewelry', 'Mobile Accessories', 'Footwear'
]

# ==================== PRODUCTS DICTIONARY ====================
products = {
    'Electronics': ['Smartphone', 'Laptop', 'Headphones', 'Smart Watch', 'Tablet', 'Bluetooth Speaker'],
    'Fashion': ['T-Shirt', 'Jeans', 'Kurta', 'Jacket', 'Saree', 'Dress'],
    'Home & Kitchen': ['Mixer Grinder', 'Cookware Set', 'Water Bottle', 'Bed Sheet', 'Refrigerator'],
    'Beauty': ['Face Cream', 'Lipstick', 'Hair Oil', 'Perfume', 'Face Wash'],
    'Books': ['Fiction Novel', 'Self Help Book', 'Exam Guide', 'Cookbook', 'Biography'],
    'Sports': ['Cricket Bat', 'Yoga Mat', 'Football', 'Badminton Racket', 'Dumbbells'],
    'Toys & Games': ['Board Game', 'Remote Car', 'Puzzle', 'Doll', 'Building Blocks'],
    'Jewelry': ['Gold Necklace', 'Silver Earrings', 'Bracelet', 'Ring'],
    'Mobile Accessories': ['Charger', 'Power Bank', 'Screen Guard', 'Earphones', 'Phone Case'],
    'Footwear': ['Sneakers', 'Formal Shoes', 'Sandals', 'Running Shoes', 'Flip Flops']
}

# ==================== GENERATE SELLERS ====================
sellers = []
for i in range(num_unique_sellers):
    sellers.append({
        'seller_id': f"SELL{1000 + i}",
        'seller_name': fake.company() + " Retail",
        'seller_city': fake.city(),
        'seller_rating': round(random.uniform(3.5, 5.0), 1)
    })

# ==================== GENERATE UNIQUE CUSTOMERS ====================
customers = []
for i in range(num_unique_customers):
    customers.append({
        'customer_id': f"CUST{10000 + i}",
        'customer_name': fake.name(),
        'city': fake.city(),
        'state': fake.state(),
        'customer_status': random.choice(customer_statuses)
    })

# ==================== GENERATE ORDERS ====================
data = []

for i in range(num_rows):
    # Weighted customer selection (active & new get more orders)
    customer = random.choices(
        customers,
        weights=[4 if c['customer_status'] in ['active', 'new'] else 1 for c in customers]
    )[0]
    
    order_id = f"ORD{100000 + i}"
    order_value = round(random.uniform(299, 45000), 2)
    
    category = random.choice(product_categories)
    product_name = random.choice(products[category])   # Fixed line
    
    order_date = fake.date_time_between(start_date="-2y", end_date="now")
    
    seller = random.choice(sellers)
    
    # 35% chance customer city == seller city
    seller_city = customer['city'] if random.random() < 0.35 else seller['seller_city']
    
    # Payment details
    payment_method = random.choice(payment_methods)
    
    # Name on payment (mismatch more common in dormant/inactive)
    if customer['customer_status'] in ['dormant', 'inactive'] and random.random() < 0.45:
        name_on_payment = fake.name()
    else:
        name_on_payment = customer['customer_name']
    
    row = {
        'customer_id': customer['customer_id'],
        'customer_name': customer['customer_name'],
        'city': customer['city'],
        'state': customer['state'],
        'customer_status': customer['customer_status'],
        
        'order_id': order_id,
        'order_value': order_value,
        'product_name': product_name,
        'product_category': category,
        'order_date': order_date.strftime('%Y-%m-%d %H:%M:%S'),
        'order_status': random.choices(order_statuses, weights=[72, 14, 6, 8])[0],
        'promotion_applied': random.choice(['yes', 'no']),
        
        'payment_details': payment_method,
        'name_on_payment': name_on_payment,
        
        'seller_id': seller['seller_id'],
        'seller_name': seller['seller_name'],
        'seller_city': seller_city,
        'seller_rating': seller['seller_rating']
    }
    
    data.append(row)

# Create and shuffle DataFrame
df = pd.DataFrame(data)
df = df.sample(frac=1, random_state=42).reset_index(drop=True)

# Save to CSV
timestamp = datetime.now().strftime('%Y%m%d_%H%M')
filename = f"ecommerce_data_{timestamp}.csv"
df.to_csv(filename, index=False)

print(f"✅ Dataset generated successfully!")
print(f"   Total Rows       : {len(df)}")
print(f"   Unique Customers : {df['customer_id'].nunique()}")
print(f"   File Saved As    : {filename}")

print("\nSample Data:")
print(df.head(5)[['customer_name', 'customer_status', 'order_id', 'product_name', 
                  'payment_details', 'name_on_payment', 'city', 'seller_city']])