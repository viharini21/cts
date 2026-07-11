import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root',
})
export class NotificationService {
  messages: string[] = [];

  push(message: string): void {
    this.messages = [...this.messages, message];
  }
}
