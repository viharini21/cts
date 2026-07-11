import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, of } from 'rxjs';

import { Course } from '../models/course.model';
import { CourseService } from './course';

@Injectable({
  providedIn: 'root',
})
export class EnrollmentService {
  private enrolledCourseIds: number[] = [];

  constructor(
    private readonly courseService: CourseService,
    private readonly http?: HttpClient,
  ) {}

  enroll(courseId: number): void {
    if (!this.enrolledCourseIds.includes(courseId)) {
      this.enrolledCourseIds.push(courseId);
    }
  }

  unenroll(courseId: number): void {
    this.enrolledCourseIds = this.enrolledCourseIds.filter((id) => id !== courseId);
  }

  isEnrolled(courseId: number): boolean {
    return this.enrolledCourseIds.includes(courseId);
  }

  getEnrolledCourses(): Course[] {
    return this.enrolledCourseIds
      .map((id) => this.courseService.getCourseById(id))
      .filter((course): course is Course => Boolean(course));
  }

  getStudentsByCourse(
    courseId: number,
  ): Observable<Array<{ id: number; name: string; courseId: number }>> {
    if (!this.http) {
      return of([]);
    }

    return this.http.get<Array<{ id: number; name: string; courseId: number }>>(
      `http://localhost:3000/students?courseId=${courseId}`,
    );
  }
}
