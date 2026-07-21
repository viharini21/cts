import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule, NgForm } from '@angular/forms';

import { CourseService } from '../../services/course';

@Component({
  selector: 'app-enrollment-form',
  imports: [CommonModule, FormsModule],
  templateUrl: './enrollment-form.html',
  styleUrl: './enrollment-form.css',
})
export class EnrollmentForm {
  model = {
    studentName: '',
    studentEmail: '',
    courseId: null as number | null,
    preferredSemester: 'Odd',
    agreeToTerms: false,
  };
  submitted = false;

  constructor(private readonly courseService: CourseService) {}

  onSubmit(form: NgForm): void {
    console.log('Template form value:', form.value, 'valid:', form.valid);
    this.submitted = form.valid ?? false;

    if (form.valid && this.model.courseId !== null) {
      this.courseService
        .createCourse({
          name: this.model.studentName + ' Enrollment',
          code: 'REQ-' + this.model.courseId,
          credits: 1,
          gradeStatus: 'pending',
        })
        .subscribe();
    }
  }
}
