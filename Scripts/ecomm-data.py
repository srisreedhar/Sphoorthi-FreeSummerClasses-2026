# Faker
## version 1
# no relations with seller and no payment
# Ecommerce Data Generator

from faker import Faker
import pandas as pd
import random
from datetime import datetime, timedelta
import numpy as np

fake = Faker('en_IN')  # Using Indian locale for realistic names & cities

# Set seed for reproducibility (good for teaching)
random.seed(42)
np.random.seed(42)
fake.seed_instance(42)

print("Generating E-commerce dataset...")

# Lists for controlled values
customer_statuses = ['active', 'inactive', 'new', 'dormant']
order_statuses = ['fulfilled', 'returned', 'lost_parcel', 'processing']
promotion_options = ['yes', 'no']
product_categories = [
    'Electronics', 'Fashion', 'Home & Kitchen', 'Beauty', 'Books', 
    'Sports', 'Toys & Games', 'Jewelry', 'Mobile Accessories', 'Footwear'
]

products = {
    'Electronics': ['Smartphone', 'Laptop', 'Headphones', 'Smart Watch', 'Tablet'],
    'Fashion': ['T-Shirt', 'Jeans', 'Kurta', 'Jacket', 'Saree'],
    'Home & Kitchen': ['Mixer Grinder', 'Cookware Set', 'Water Bottle', 'Bed Sheet'],
    'Beauty': ['Face Cream', 'Lipstick', 'Hair Oil', 'Perfume'],
    'Books': ['Fiction Novel', 'Self Help Book', 'Exam Guide', 'Cookbook'],
    'Sports': ['Cricket Bat', 'Yoga Mat', 'Football', 'Badminton Racket'],
    'Toys & Games': ['Board Game', 'Remote Car', 'Puzzle', 'Doll'],
    'Jewelry': ['Gold Necklace', 'Silver Earrings', 'Bracelet'],
    'Mobile Accessories': ['Charger', 'Power Bank', 'Screen Guard', 'Earphones'],
    'Footwear': ['Sneakers', 'Formal Shoes', 'Sandals', 'Running Shoes']
}

# Generate Sellers first (fewer unique sellers)
sellers = []
for i in range(25):  # 25 unique sellers
    sellers.append({
        'seller_id': f"SELL{1000 + i}",
        'seller_name': fake.company() + " Retail",
        'seller_city': fake.city(),
        'seller_rating': round(random.uniform(3.5, 5.0), 1)
    })

# Generate Customers and Orders
data = []
num_rows = 1200  # Generating 1200 rows

for i in range(num_rows):
    # Customer details
    customer_name = fake.name()
    city = fake.city()
    state = fake.state()
    
    # Order details
    order_id = f"ORD{100000 + i}"
    order_value = round(random.uniform(299, 45000), 2)
    
    category = random.choice(product_categories)
    product_name = random.choice(products[category])
    
    # Order date - last 2 years
    order_date = fake.date_time_between(start_date="-2y", end_date="now")
    
    # Seller (random seller)
    seller = random.choice(sellers)
    
    row = {
        'customer_id': f"CUST{10000 + random.randint(1, 800)}",
        'customer_name': customer_name,
        'city': city,
        'state': state,                    # also called customer_state
        'customer_status': random.choice(customer_statuses),
        
        'order_id': order_id,
        'order_value': order_value,
        'product_name': product_name,
        'product_category': category,
        'order_date': order_date.strftime('%Y-%m-%d %H:%M:%S'),
        'order_status': random.choices(order_statuses, weights=[70, 15, 5, 10])[0],
        'promotion_applied': random.choice(promotion_options),
        
        'seller_id': seller['seller_id'],
        'seller_name': seller['seller_name'],
        'seller_city': seller['seller_city'],
        'seller_rating': seller['seller_rating']
    }
    
    data.append(row)

# Create DataFrame
df = pd.DataFrame(data)

# Shuffle the data
df = df.sample(frac=1, random_state=42).reset_index(drop=True)

# Save to CSV
filename = f"ecommerce_data_{datetime.now().strftime('%Y%m%d_%H%M')}.csv"
df.to_csv(filename, index=False)

print(f"✅ Dataset generated successfully!")
print(f"   Rows: {len(df)}")
print(f"   Columns: {len(df.columns)}")
print(f"   File saved as: {filename}")

# Show sample
print("\nSample Data:")
print(df.head(5)[['customer_name', 'order_id', 'order_value', 'product_category', 
                  'order_status', 'promotion_applied', 'seller_name']])