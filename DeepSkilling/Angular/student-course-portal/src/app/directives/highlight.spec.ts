import { provideRouter } from '@angular/router';
import { provideHttpClient } from '@angular/common/http';
import { ElementRef } from '@angular/core';
import { Highlight } from './highlight';

describe('Highlight', () => {
  it('should create an instance', () => {
    const el = new ElementRef(document.createElement('div'));
    const directive = new Highlight(el);
    expect(directive).toBeTruthy();
  });
});
