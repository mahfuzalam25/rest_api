from django.core.mail import send_mail

def send_otp_email(email, otp):
    subject = "Password Reset Verification Code"
    message = f"Your verification code is: {otp}. It will expire in 10 minutes."
    from_email = "noreply@example.com"
    recipient_list = [email]
    send_mail(subject, message, from_email, recipient_list)
