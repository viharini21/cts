import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';

import { NotificationService } from '../../services/notification';

@Component({
  selector: 'app-notification',
  imports: [CommonModule],
  templateUrl: './notification.html',
  styleUrl: './notification.css',
  providers: [NotificationService],
})
export class Notification {
  constructor(private readonly notificationService: NotificationService) {
    // Component providers create a fresh instance scoped to this component tree.
    this.notificationService.push('Notification component initialized.');
  }

  get messages(): string[] {
    return this.notificationService.messages;
  }
}
