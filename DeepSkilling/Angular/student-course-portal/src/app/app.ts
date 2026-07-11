import { Component } from '@angular/core';
import { AsyncPipe, NgIf } from '@angular/common';
import { RouterOutlet } from '@angular/router';

import { Header } from './components/header/header';
import { LoadingService } from './services/loading';

@Component({
  selector: 'app-root',
  imports: [Header, RouterOutlet, NgIf, AsyncPipe],
  templateUrl: './app.html',
  styleUrl: './app.css',
})
export class App {
  title = 'Student Course Portal';

  constructor(public readonly loadingService: LoadingService) {}
}
