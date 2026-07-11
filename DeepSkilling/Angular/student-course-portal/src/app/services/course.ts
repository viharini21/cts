import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, catchError, map, of, retry, tap, throwError } from 'rxjs';

import { Course } from '../models/course.model';

@Injectable({
  providedIn: 'root',
})
export class CourseService {
  private readonly apiUrl = 'http://localhost:3000/courses';

  private courses: Course[] = [
    { id: 1, name: 'Data Structures', code: 'CS101', credits: 4, gradeStatus: 'passed' },
    { id: 2, name: 'Angular Fundamentals', code: 'NG201', credits: 3, gradeStatus: 'pending' },
    { id: 3, name: 'Database Systems', code: 'DB150', credits: 4, gradeStatus: 'failed' },
    { id: 4, name: 'Operating Systems', code: 'OS210', credits: 3, gradeStatus: 'pending' },
    { id: 5, name: 'Cloud Basics', code: 'CL110', credits: 2, gradeStatus: 'passed' },
  ];

  constructor(private readonly http?: HttpClient) {}

  getCourses(): Course[] {
    return [...this.courses];
  }

  getCourseById(id: number): Course | undefined {
    return this.courses.find((course) => course.id === id);
  }

  addCourse(course: Course): void {
    this.courses = [...this.courses, course];
  }

  getCoursesHttp(): Observable<Course[]> {
    if (!this.http) {
      return of(this.getCourses());
    }

    return this.http.get<Course[]>(this.apiUrl).pipe(
      map((courses) => courses.filter((c) => (c.credits ?? 0) > 0)),
      tap((courses) => console.log('Courses loaded:', courses.length)),
      retry(2),
      catchError((err) => {
        console.error(err);
        return throwError(() => new Error('Failed to load courses. Please try again.'));
      }),
    );
  }

  getCourseByIdHttp(id: number): Observable<Course> {
    if (!this.http) {
      const fallback = this.getCourseById(id);
      if (fallback) {
        return of(fallback);
      }
      return throwError(() => new Error('Course not found'));
    }

    return this.http.get<Course>(`${this.apiUrl}/${id}`);
  }

  createCourse(course: Omit<Course, 'id'>): Observable<Course> {
    if (!this.http) {
      const created: Course = {
        id: Date.now(),
        ...course,
      };
      this.addCourse(created);
      return of(created);
    }

    return this.http.post<Course>(this.apiUrl, course);
  }

  updateCourse(id: number, course: Partial<Course>): Observable<Course> {
    if (!this.http) {
      const existing = this.getCourseById(id);
      if (!existing) {
        return throwError(() => new Error('Course not found'));
      }
      const updated = { ...existing, ...course };
      this.courses = this.courses.map((item) => (item.id === id ? updated : item));
      return of(updated);
    }

    return this.http.put<Course>(`${this.apiUrl}/${id}`, course);
  }

  deleteCourse(id: number): Observable<void> {
    if (!this.http) {
      this.courses = this.courses.filter((course) => course.id !== id);
      return of(void 0);
    }

    return this.http.delete<void>(`${this.apiUrl}/${id}`);
  }
}
