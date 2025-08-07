# 🌐 Chrome Multi-Tab Authentication Testing Guide

## 🚀 Application Status: RUNNING ✅

- **Django Backend**: http://localhost:8000 ✅ ACTIVE
- **React Frontend**: http://localhost:3000 ✅ ACTIVE
- **Chrome Browser**: Application opened automatically

## 🧪 Step-by-Step Testing Instructions

### 1. Initial Setup Test
1. **Open Chrome** (should already be open at http://localhost:3000)
2. **Verify Login Page**: You should see a beautiful Material-UI login form
3. **Check Console**: Open Chrome DevTools (F12) - no errors should appear

### 2. Single Tab Login Test
1. **Enter Credentials**:
   - Email: `admin@example.com`
   - Password: `admin123`
2. **Click Login**
3. **Expected Result**: Redirect to dashboard showing:
   - Welcome message
   - User information (admin user)
   - Session management status
   - Multi-tab feature descriptions

### 3. Multi-Tab Login Synchronization Test 🔄
1. **Open 2+ new Chrome tabs** to http://localhost:3000
2. **All tabs should show login page**
3. **Login from ONE tab only** using admin credentials
4. **Expected Result**: ALL other tabs automatically redirect to dashboard
5. **Verification**: No manual login needed in other tabs

### 4. Activity Extension Test ⏱️
1. **Have 3+ tabs open and logged in**
2. **Stay active in ONE tab** (click, move mouse, scroll)
3. **Keep other tabs inactive**
4. **Expected Result**: Session stays active in ALL tabs due to activity in one tab

### 5. Session Warning Test ⚠️
**Timing**: Session timeout is now set to 3 minutes with warning at 1 minute remaining.

1. **Stay completely inactive** in all tabs for 2 minutes
2. **At 2 minutes (1 minute remaining)**: Beautiful popup appears with:
   - "Session Expiring Soon" title
   - Warning icon
   - "Session expires in 1 minute" message
   - Two buttons: "Logout Now" and "Extend Session"
3. **Test "Extend Session"**: Resets timer for all tabs
4. **Test "Logout Now"**: Immediately logs out all tabs

### 6. Automatic Logout Test 🔓
1. **Stay inactive** for the full 3 minutes (beyond the session timeout)
2. **Expected Result**: Automatic logout from all tabs at 3 minutes
3. **Verification**: All tabs redirect to login page

### 7. Multi-Tab Logout Synchronization Test 🚪
1. **Have multiple tabs open and logged in**
2. **Click "Logout" button in ONE tab**
3. **Expected Result**: ALL other tabs immediately redirect to login page
4. **Verification**: Manual logout affects all tabs instantly

### 8. Token Security Test 🛡️
1. **Open Chrome DevTools** → Application → Local Storage
2. **After login**: Should see `access_token`, `refresh_token`, `last_activity`
3. **After logout**: All tokens should be cleared
4. **Refresh page after logout**: Should remain on login page (no auto-login)

## 🔍 Chrome DevTools Monitoring

### Console Messages to Look For:
- ✅ No JavaScript errors during login/logout
- ✅ Clean API responses (200 status codes)
- ✅ Storage events firing for multi-tab sync

### Network Tab Monitoring:
- ✅ POST `/api/login/` returns user data and tokens
- ✅ GET `/api/check/` validates authentication
- ✅ POST `/api/logout/` properly invalidates tokens
- ✅ POST `/api/token/refresh/` handles token renewal

### Local Storage to Monitor:
```
access_token: "eyJhbGciOiJIUzI1NiIs..."
refresh_token: "eyJhbGciOiJIUzI1NiIs..."
last_activity: "1754453552000"
session_id: "1754453552123"
```

## 🎯 Expected Multi-Tab Behaviors

### ✅ What Should Work:
1. **Login Sync**: Login in tab A → Auto-login in tabs B, C, D
2. **Activity Sync**: Activity in tab A → Session extended in all tabs
3. **Logout Sync**: Logout in tab A → Auto-logout in tabs B, C, D
4. **Warning Sync**: Warning appears in ALL tabs simultaneously
5. **Timer Sync**: Activity in any tab resets timers in all tabs

### ❌ What Should NOT Happen:
1. **Multiple Logins**: Should not need to login separately in each tab
2. **Session Conflicts**: Session should never be active in some tabs but not others
3. **Timer Desync**: Timers should never be out of sync between tabs
4. **Token Duplication**: Should not create multiple sets of tokens

## 🐛 Troubleshooting

### If Login Doesn't Work:
```bash
# Check Django server logs
curl -X POST http://localhost:8000/api/login/ \
  -H "Content-Type: application/json" \
  -d '{"email": "admin@example.com", "password": "admin123"}'
```

### If Multi-Tab Sync Fails:
1. **Check Local Storage Events**: Open DevTools in multiple tabs
2. **Verify Storage Keys**: Ensure same localStorage keys across tabs
3. **Check Console Errors**: Look for JavaScript errors preventing sync

### If Session Warning Doesn't Appear:
1. **Check Timer Logic**: Verify timers are being set correctly
2. **Test with Shorter Timeout**: Modify constants for faster testing
3. **Monitor State Changes**: Check React state updates in DevTools

## 🎉 Success Criteria

The application is working correctly if:
- ✅ All 7 test scenarios pass
- ✅ No console errors in Chrome DevTools
- ✅ Clean network requests (200/201/204 status codes)
- ✅ Proper token management in localStorage
- ✅ Beautiful, responsive UI in all screen sizes
- ✅ Smooth user experience across all interactions

## 🚀 Ready for Production!

Once all tests pass, the multi-tab authentication system is:
- **Secure**: Proper JWT token handling with refresh and blacklisting
- **Synchronized**: Real-time multi-tab communication
- **User-Friendly**: Clear warnings and smooth experience
- **Robust**: Handles edge cases and provides fallbacks

**Application URL**: http://localhost:3000 🌐 