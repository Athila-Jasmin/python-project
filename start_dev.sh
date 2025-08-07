#!/bin/bash

# Django React Authentication App Startup Script

echo "🚀 Starting Django React Authentication App..."

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is not installed. Please install Python 3 first."
    exit 1
fi

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js first."
    exit 1
fi

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "❌ npm is not installed. Please install npm first."
    exit 1
fi

echo "✅ Prerequisites check passed"

# Install Django dependencies
echo "📦 Installing Django dependencies..."
pip3 install -r requirements.txt

# Run Django migrations
echo "🗄️ Running Django migrations..."
python3 manage.py migrate

# Create superuser if it doesn't exist
echo "👤 Creating superuser (if needed)..."
python3 manage.py shell -c "
from django.contrib.auth import get_user_model
User = get_user_model()
if not User.objects.filter(username='admin').exists():
    User.objects.create_superuser('admin', 'admin@example.com', 'admin123')
    print('Superuser created: admin/admin123')
else:
    print('Superuser already exists')
"

# Install frontend dependencies
echo "📦 Installing frontend dependencies..."
cd frontend
npm install

# Start Django backend in background
echo "🔧 Starting Django backend on http://localhost:8000..."
cd ..
python3 manage.py runserver 8000 &
DJANGO_PID=$!

# Wait a moment for Django to start
sleep 3

# Start React frontend
echo "⚛️ Starting React frontend on http://localhost:3000..."
cd frontend
npm start &
REACT_PID=$!

echo ""
echo "🎉 Application started successfully!"
echo ""
echo "📱 Frontend: http://localhost:3000"
echo "🔧 Backend: http://localhost:8000"
echo "👤 Admin: http://localhost:8000/admin (admin/admin123)"
echo ""
echo "🔄 Multi-tab features to test:"
echo "   • Open multiple tabs of the frontend"
echo "   • Login from one tab - others will auto-login"
echo "   • Logout from one tab - others will auto-logout"
echo "   • Stay inactive for 30 minutes to test auto-logout"
echo ""
echo "Press Ctrl+C to stop both servers"

# Auto-launch React app in Google Chrome
open -a "Google Chrome" http://localhost:3000

# Wait for user to stop
trap "echo '🛑 Stopping servers...'; kill $DJANGO_PID $REACT_PID; exit" INT
wait 