#!/bin/bash
# إنشاء المجلدات الأساسية
mkdir -p Saksaphani/app/auth Saksaphani/app/admin Saksaphani/app/cart Saksaphani/app/checkout Saksaphani/app/category Saksaphani/app/products
mkdir -p Saksaphani/components/cart Saksaphani/components/icons
mkdir Saksaphani/models Saksaphani/lib Saksaphani/data
mkdir -p Saksaphani/public/images/products Saksaphani/public/icons

cd Saksaphani

# إنشاء الملفات الأساسية
cat > package.json <<EOL
{
  "name": "saksaphani",
  "version": "1.0.0",
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start"
  },
  "dependencies": {
    "next": "latest",
    "react": "latest",
    "react-dom": "latest",
    "tailwindcss": "^3.3.2",
    "postcss": "^8.4.21",
    "autoprefixer": "^10.4.14",
    "bcryptjs": "^2.4.3",
    "jsonwebtoken": "^9.0.0",
    "stripe": "^12.0.0"
  }
}
EOL

cat > tailwind.config.js <<EOL
module.exports = {
  content: ['./app/**/*.{js,ts,jsx,tsx}','./components/**/*.{js,ts,jsx,tsx}'],
  theme: {
    extend: {
      colors: { gold:'#FFD700' }
    },
  },
  plugins: [],
}
EOL

cat > .env.example <<EOL
MONGO_URI=YOUR_MONGO_URI
JWT_SECRET=YOUR_JWT_SECRET
STRIPE_SECRET_KEY=YOUR_STRIPE_SECRET_KEY
NEXT_PUBLIC_URL=http://localhost:3000
PAYPAL_CLIENT_ID=YOUR_PAYPAL_CLIENT_ID
PAYPAL_SECRET=YOUR_PAYPAL_SECRET
EOL

cat > globals.css <<EOL
@tailwind base;
@tailwind components;
@tailwind utilities;

:root {
  --gold: #FFD700;
}

body {
  background-color: #000;
  color: #fff;
  font-family: sans-serif;
}
EOL

# إنشاء ملفات Models
cat > models/User.js <<EOL
import mongoose from "mongoose";
const UserSchema = new mongoose.Schema({
  name:{type:String,required:true},
  email:{type:String,required:true,unique:true},
  password:{type:String,required:true},
  role:{type:String,enum:["user","admin"],default:"user"}
},{timestamps:true});
export default mongoose.models.User || mongoose.model("User",UserSchema);
EOL

cat > models/Product.js <<EOL
import mongoose from "mongoose";
const ProductSchema = new mongoose.Schema({
  title:{type:String,required:true},
  description:String,
  price:{type:Number,required:true},
  category:String,
  images:[String],
  inStock:{type:Boolean,default:true}
},{timestamps:true});
export default mongoose.models.Product || mongoose.model("Product",ProductSchema);
EOL

cat > models/Order.js <<EOL
import mongoose from "mongoose";
const OrderSchema = new mongoose.Schema({
  userId:{type:mongoose.Schema.Types.ObjectId,ref:"User",required:true},
  products:[{productId:{type:mongoose.Schema.Types.ObjectId,ref:"Product"},qty:{type:Number,default:1}}],
  total:{type:Number,required:true},
  paymentMethod:{type:String,enum:["card","paypal","cod"],default:"paypal"},
  status:{type:String,enum:["pending","paid","shipped","completed","canceled"],default:"pending"},
  shippingInfo:{fullname:String,address:String,city:String,country:String,phone:String}
},{timestamps:true});
export default mongoose.models.Order || mongoose.model("Order",OrderSchema);
EOL

cat > models/Coupon.js <<EOL
import mongoose from "mongoose";
const CouponSchema = new mongoose.Schema({
  code:{type:String,required:true,unique:true},
  discount:{type:Number,required:true},
  expiresAt:{type:Date,required:true},
  isActive:{type:Boolean,default:true}
},{timestamps:true});
export default mongoose.models.Coupon || mongoose.model("Coupon",CouponSchema);
EOL

# إنشاء Lib
cat > lib/db.js <<EOL
import mongoose from "mongoose";
export const connectDB=async()=>{
  if(mongoose.connection.readyState>=1) return;
  try{await mongoose.connect(process.env.MONGO_URI);console.log("MongoDB Connected");}catch(err){console.error("DB Error:",err);}
}
EOL

cat > lib/auth.js <<EOL
import jwt from "jsonwebtoken";
import User from "../models/User";
import { connectDB } from "./db";
export const verifyToken=async(token)=>{
  await connectDB();
  try{const decoded=jwt.verify(token,process.env.JWT_SECRET);return await User.findById(decoded.id);}catch{return null;}
}
EOL

cat > lib/validations.js <<EOL
export const validateRegister=(data)=>{return data.name && data.email && data.password;}
export const validateProduct=(data)=>{return data.title && data.price && data.category;}
EOL

echo "Setup complete! Now copy additional components and pages as per the project instructions."
