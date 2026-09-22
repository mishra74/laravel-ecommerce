<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class LoginOtpNotification extends Notification
{
    use Queueable;

    public function __construct(protected string $otp)
    {
    }

    public function via($notifiable): array
    {
        return ['mail'];
    }

    public function toMail($notifiable): MailMessage
    {
        return (new MailMessage)
            ->subject('Your White Elegance 24 login code')
            ->greeting('Hello ' . $notifiable->name . ',')
            ->line('Use this code to log in:')
            ->line(new \Illuminate\Support\HtmlString(
                '<div style="font-size:28px;font-weight:bold;letter-spacing:6px;text-align:center;margin:16px 0;">'
                . $this->otp . '</div>'
            ))
            ->line('This code expires in 10 minutes.')
            ->line("If you didn't request this, no further action is needed.");
    }
}
