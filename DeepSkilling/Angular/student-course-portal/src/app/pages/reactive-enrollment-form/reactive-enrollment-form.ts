import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import {
  AbstractControl,
  FormArray,
  FormBuilder,
  ReactiveFormsModule,
  ValidationErrors,
  Validators,
} from '@angular/forms';

@Component({
  selector: 'app-reactive-enrollment-form',
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: './reactive-enrollment-form.html',
  styleUrl: './reactive-enrollment-form.css',
})
export class ReactiveEnrollmentForm implements OnInit {
  enrollForm = this.fb.group({
    studentName: ['', [Validators.required, Validators.minLength(3)]],
    studentEmail: ['', [Validators.required, Validators.email], [this.simulateEmailCheck]],
    courseId: ['', [Validators.required, this.noCourseCode]],
    preferredSemester: ['Odd', Validators.required],
    agreeToTerms: [false, Validators.requiredTrue],
    additionalCourses: this.fb.array([]),
  });

  constructor(private readonly fb: FormBuilder) {}

  ngOnInit(): void {}

  noCourseCode(control: AbstractControl): ValidationErrors | null {
    const value = String(control.value ?? '');
    return value.startsWith('XX') ? { noCourseCode: true } : null;
  }

  simulateEmailCheck(control: AbstractControl): Promise<ValidationErrors | null> {
    return new Promise((resolve) => {
      setTimeout(() => {
        resolve(String(control.value ?? '').includes('test@') ? { emailTaken: true } : null);
      }, 800);
    });
  }

  // value excludes disabled controls; getRawValue includes every control.
  submit(): void {
    console.log('Reactive form value:', this.enrollForm.value);
    console.log('Reactive raw value:', this.enrollForm.getRawValue());
  }

  addCourse(): void {
    this.additionalCourses.push(this.fb.control('', Validators.required));
  }

  removeCourse(index: number): void {
    this.additionalCourses.removeAt(index);
  }

  // Typed getter avoids repetitive casting in template expressions.
  get additionalCourses(): FormArray {
    return this.enrollForm.get('additionalCourses') as FormArray;
  }

  hasPendingChanges(): boolean {
    return this.enrollForm.dirty;
  }
}
