import { provideRouter } from '@angular/router';
import { provideHttpClient } from '@angular/common/http';
import { CreditLabelPipe } from './credit-label-pipe';

describe('CreditLabelPipe', () => {
  it('create an instance', () => {
    const pipe = new CreditLabelPipe();
    expect(pipe).toBeTruthy();
  });
});
