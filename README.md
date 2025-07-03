
# Django REST API with OAuth2 Authentication (drf-social-oauth2)

A secure Django REST API using **OAuth2 authentication** with `drf-social-oauth2` and Django REST Framework. This backend system enables secure token-based authentication and user management.

---

## 🔐 Features

- OAuth2 Token Authentication (`password` grant type)
- Secure token revocation
- User registration, login, logout, and profile management
- Password update with old password verification
- Automatic Profile creation using Django signals
- Custom permissions for user/profile ownership
- Works with mobile or web API clients (e.g., Flutter, Postman)

---

## 🛠 Tech Stack

- **Framework**: Django, Django REST Framework
- **Auth**: drf-social-oauth2, Django OAuth Toolkit
- **Database**: PostgreSQL (or any Django-supported DB)

---

## 🚀 Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/your-project.git
cd your-project
```

### 2. Create a Virtual Environment

```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

### 3. Install Dependencies

```bash
pip install -r requirements.txt
```

### 4. Run Migrations

```bash
python manage.py migrate
```

### 5. Create Superuser

```bash
python manage.py createsuperuser
```

### 6. Run the Server

```bash
python manage.py runserver
```

---

## 🔑 OAuth2 Setup

### Create OAuth2 Application (via Django Admin)

- Go to: `/admin`
- Add new application:
  - Client Type: `Confidential`
  - Grant Type: `Resource owner password-based`
  - User: Your superuser
- Save and **copy the client ID and secret** immediately

---

## 🔗 API Endpoints

| Endpoint                  | Method | Description                    |
|---------------------------|--------|--------------------------------|
| `/api/auth/token/`        | POST   | Get access token               |
| `/api/auth/revoke-token/`| POST   | Revoke (logout) token          |
| `/api/accounts/users/`    | GET/POST | User list / Create user       |
| `/api/accounts/users/<id>/`| PUT/PATCH | Update user profile         |
| `/api/accounts/profiles/` | GET/PUT | Get/update profile            |

---

## 🧠 Notes

- Tokens are stored and verified securely via Django OAuth Toolkit
- Password changes do not revoke existing tokens unless manually handled
- Use `Authorization: Bearer <access_token>` in headers for all API requests
- Django signals create a Profile automatically for each new User

---

## ✍️ Author

**Mahfuz Alam Chowdhury**  
Backend Developer – Django | DRF | OAuth2

---

## 📜 License

MIT License — Use freely with attribution.
