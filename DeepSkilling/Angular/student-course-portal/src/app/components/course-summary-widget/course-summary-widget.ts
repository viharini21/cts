import { Component } from '@angular/core';

import { CourseService } from '../../services/course';

@Component({
  selector: 'app-course-summary-widget',
  imports: [],
  templateUrl: './course-summary-widget.html',
  styleUrl: './course-summary-widget.css',
})
export class CourseSummaryWidget {
  constructor(private readonly courseService: CourseService) {}

  get totalCourses(): number {
    return this.courseService.getCourses().length;
  }

  addDemoCourse(): void {
    this.courseService.addCourse({
      id: Date.now(),
      name: 'New elective',
      code: 'EL-' + Math.floor(Math.random() * 1000),
      credits: 2,
      gradeStatus: 'pending',
    });
  }
}
